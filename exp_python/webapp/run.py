import uvicorn
import sys

if __name__ == "__main__":
    # freeze_support()
    sys.argv.insert(1, "exp_python.webapp.main:app")
    sys.exit(uvicorn.main())
