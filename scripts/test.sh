#!/bin/bash
# Activate virtual environment
. /appenv/bin/activate

# Install applications test requirements
pip install -r requirements_test.txt

# Run test.sh arguments
exec $@