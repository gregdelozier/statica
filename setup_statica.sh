#!/bin/bash

# Define project name
PROJECT_NAME="statica"

# Create directory structure
mkdir -p $PROJECT_NAME/{statica,templates,examples,tests,.github/workflows}

# Create empty Python package files
touch $PROJECT_NAME/statica/__init__.py

# Create main script file
touch $PROJECT_NAME/statica/statica.py

# Create setup and build files
touch $PROJECT_NAME/setup.py

touch $PROJECT_NAME/pyproject.toml

# Create README and License
cat <<EOF > $PROJECT_NAME/README.md
# Statica

Statica is a lightweight Markdown-to-HTML static site generator.

## Installation
```sh
pip install statica
```

## Usage
```sh
statica __source__ .
```

## License
MIT License
EOF

touch $PROJECT_NAME/LICENSE

# Create .gitignore
echo "dist/\n__pycache__/\n*.pyc" > $PROJECT_NAME/.gitignore

# Create GitHub Actions workflow
cat <<EOF > $PROJECT_NAME/.github/workflows/publish.yml
name: Publish to PyPI

on:
  release:
    types: [created]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Set up Python
      uses: actions/setup-python@v3
      with:
        python-version: "3.10"

    - name: Install dependencies
      run: pip install build twine

    - name: Build package
      run: python -m build

    - name: Publish to PyPI
      env:
        TWINE_USERNAME: \${{ secrets.PYPI_USERNAME }}
        TWINE_PASSWORD: \${{ secrets.PYPI_PASSWORD }}
      run: python -m twine upload dist/*
EOF

# Print success message
echo "Project structure for '$PROJECT_NAME' has been created!"
