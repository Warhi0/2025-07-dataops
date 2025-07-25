@echo off
REM Script สำหรับรัน tests ในเครื่อง local (ใช้ Conda)
echo 🧪 Running Unit Tests for Loan ETL Pipeline...
echo ============================================

REM Activate conda environment
echo 🔧 Activating conda environment: python3.8...
call conda activate python3.8

REM Check if activation was successful
if "%CONDA_DEFAULT_ENV%"=="python3.8" (
    echo ✅ Successfully activated conda environment: %CONDA_DEFAULT_ENV%
) else (
    echo ❌ Failed to activate conda environment!
    exit /b 1
)

REM Run tests with coverage
echo 📊 Running tests with coverage...
pytest tests/ -v --cov=pre-production/etl --cov-report=term-missing --cov-report=html

REM Check exit code
if %ERRORLEVEL% equ 0 (
    echo.
    echo ✅ All tests passed!
    echo 📈 Coverage report saved to: htmlcov/index.html
) else (
    echo.
    echo ❌ Some tests failed!
    conda deactivate
    exit /b 1
)

echo.
echo ✨ Testing completed!

REM Deactivate conda environment
conda deactivate
echo 🔧 Conda environment deactivated