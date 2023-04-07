import unittest
import utils
class TestUtil(unittest.TestCase):
    def test_add(self):
        self.assertEqual(utils.add(1, 2), 3)
        self.assertEqual(utils.add(1, 2, 3), 6)

    def test_sub(self):
        self.assertEqual(utils.sub(3, 2), 1)

    def test_add_numbers(self):
        self.assertEqual(utils.add_numbers(1, 2), 3)



