# CementAT, CO2 emissions and CO2 transportation of Austrian Cement Industry

![CementAT](https://img.shields.io/badge/CementAT-v1.0-blue)
CementAT is a project that visualizes the Austrian cement plants and their corresponding CO2 emissions, as well as calculates the CO2 transportation costs for transporting the emissions to possible CO2 storage sites/ports, using different modes of transportation.

## Documentation and Support
* `Cement_AT.R`
This component contains data and visualization on the Austrian cement industry, including the locations of cement plants, their corresponding CO2 emissions, and their capacities.
* `Transportation_AT.R`
This component contains data on the transportation of CO2 emissions from the cement plants to possible CO2 storage sites/ports, using different modes of transportation. It includes the distances between the plants and the storage sites/ports, the CO2 transportation capacity, and the transportation costs.
* `test_transport.py`, `test_map.py`
This component includes a test script to ensure that the code runs without errors. You can run the test script using the following command in your terminal after installing Conda:
```r
conda create --name CementAT_env
conda activate CementAT_env
python -m unittest test_transport.py
python -m unitest test_map.py
```

## Installation and Packages
To use the project, simply download the code from GitHub and run it in R. Or you can clone the repository from Github using the following command in your terminal:
```r 
git clone https://github.com/username/CementAT.git
```

Packages of R needed in this project:
```r 
install.packages("ggplot2")
install.packages("geojsonio")
install.packages("geosphere")
install.packages("openxlsx")
```


## Contributing
We welcome contributions to CementAT. Please feel free to submit pull requests or contact us with any suggestions or issues.

## License
This project is licensed under the MIT license.
### The MIT License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  

## Contact
If you have questions or comments about CementAT, please contact me at pingpingping.wang@tuwien.ac.at.
Copyright 2023 Pingping Wang
