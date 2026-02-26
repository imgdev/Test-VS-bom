# using uv's derived image with python 3.12 on bookworm-slim
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

WORKDIR /app

# copy all files; rely on .dockerignore to skip gitignore stuff
ADD . /app

# sync the project environment (lockfile frozen)
RUN uv sync --frozen

# convert all .ipynb -> .py at build time
# assumes convert_notebooks.py is in /app and notebooks are under /app/notebooks
RUN uv run python convert_ipynb_to_py.py

# run the main app; change 'app.py' if needed
CMD ["uv", "run", "Test.py"]