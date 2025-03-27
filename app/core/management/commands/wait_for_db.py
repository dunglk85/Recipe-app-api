"""
Django command to wait for the database to be available.
"""
from django.core.management.base import BaseCommand  # type: ignore
import time
from psycopg2 import OperationalError as Psycog2OpError  # type: ignore
from django.db.utils import OperationalError  # type: ignore


class Command(BaseCommand):
    """Django command to wait for database."""

    def handle(self, *args, **options):
        self.stdout.write("Waiting for database...")
        db_conn = False
        while db_conn is False:
            try:
                self.check(databases=["default"])
                db_conn = True  # Kiểm tra xem có thể mở kết nối không
            except (OperationalError, Psycog2OpError):
                self.stdout.write("Database unavailable, waiting 1 second...")
                time.sleep(1)
        self.stdout.write(self.style.SUCCESS("Database available!"))
