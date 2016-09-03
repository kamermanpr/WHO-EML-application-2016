# Gabapentin for Neuropathic Pain

## About
This repository contains all the files required to generate the application (and supporting documents) the International Association for the Study of Pain (IASP) and the International Association of Hospice and Palliative Care (IAHPC) made to the 21st meeting of the WHO Expert Committee on Selection and Use of Essential Medicines (2017) for the inclusion of gabapentin on the WHO Model List of Essential Medicines for the treatment of neuropathic pain. 

Follow the steps below to generate the application, appendices, and the executive summary.

#### If you use Git/GitHub: 
1. _Fork_ the repository to your GitHub account 

2. _Clone_ the repository to your computer 

3. Open a _terminal_ (Windows users should open a _Git Bash_ terminal) and change the path to the root directory of the respository  

4. Type _'make'_ (Windows users will need to download and install [_GNU Make_](http://gnuwin32.sourceforge.net/downlinks/make.php) beforehand)  

 
#### If you do not use Git/GitHub:
1. Windows users must download and install:
    - [_Git for Windows_](https://github.com/git-for-windows/git/releases) or any other _Bash_-like shell for Windows
    - [_GNU Make_](http://gnuwin32.sourceforge.net/downlinks/make.php)

2. _Download_ the respository as a zip file 

2. _Unzip_ the repository on your computer 

3. Open a _terminal_ and change the path to the root directory of the respository

4. Type _'make'_

## The following set-up was used to generate all files
- R version 3.2.4 (2016-03-10) running on RStudio v0.99.1243 for OSX
- Packages used (inclusive of: _application.Rmd_, _appendices.Rmd_, _summary.Rmd_, and all other analysis scripts):
    - ggplot2_2.1.0   
    - scales_0.4.0
    - gridExtra_2.2.1
    - xtable_1.8-2
    - pander_0.6.0
    - readr_1.0.0
    - stringr_1.1.0
    - readr_1.0.0       
    - tidyr_0.6.0
    - tibble_1.2        
    - dplyr_0.5.0
