## a test script to ensure that the code runs without errors
import subprocess

def test_r_script():
    result = subprocess.run(['Rscript', 'Transportation.R'], capture_output=True)
    assert result.returncode == 0, f"Error: {result.stderr.decode()}"

if __name__ == '__main__':
    test_r_script()
