#check if the file png exists in the current directory
import os.path
import unittest

class TestMap(unittest.TestCase):
    def test_map_file_exists(self):
        self.assertTrue(os.path.isfile("cement_map_AT.png"))


