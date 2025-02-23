@echo off
REM Check if virtual environment exists, if not create it
if not exist ".venv" (
    echo Creating virtual environment...
    python -m venv .venv
    
    REM Install dependencies if needed
    if not exist ".venv\Scripts\pip.exe" (
        echo Installing pip...
        python -m ensurepip --upgrade
    )
    
    REM Set UV to use copy mode instead of hardlinks
    set UV_LINK_MODE=copy
    
    REM Install project dependencies
    echo Installing dependencies for the first time...
    pip install -e .
    pip install langgraph-cli[inmem]
) else (
    echo Virtual environment already exists, skipping installation...
)

REM Activate virtual environment
call .venv\Scripts\activate.bat

REM Start the LangGraph server
echo Starting the LangGraph server...
langgraph dev

REM Keep the window open if there's an error
pause 