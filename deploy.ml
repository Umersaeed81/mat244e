name: deploy

on:
  # Trigger the workflow on push to main branch
  push:
    branches:
      - main

# This job installs dependencies, build the book, and pushes it to `gh-pages`
jobs:
  build-and-deploy-book:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest]
        python-version: [3.8]
    steps:
    - uses: actions/checkout@v2

    # Install dependencies
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v1
      with:
        python-version: ${{ matrix.python-version }}
    - name: Install dependencies
      run: |
        pip install -r requirements.txt

    # Build the book
    - name: Build the book
      run: |
        jupyter-book build course_class_files
        
        
    # Deploy the book's HTML to gh-pages branch
    - name: GitHub Pages action
      uses: peaceiris/actions-gh-pages@v3.6.1
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: course_class_files/_build/html
