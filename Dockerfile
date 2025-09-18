FROM python:3.13-slim

WORKDIR /app

COPY pyproject.toml poetry.lock* README.md /app/

RUN apt-get update && apt-get install -y build-essential gcc \
    && pip install --upgrade pip \
    && pip install poetry \
    && poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi --no-root

COPY . /app

CMD ["sh", "-c", "alembic upgrade head && uvicorn app.main:app --host 0.0.0.0 --port 8000"]
