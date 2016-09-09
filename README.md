# Gabapentin for Neuropathic Pain

## About
This repository contains all the files required to generate the application (and supporting documents) the International Association for the Study of Pain (IASP) and the International Association of Hospice and Palliative Care (IAHPC) made to the 21st meeting of the WHO Expert Committee on Selection and Use of Essential Medicines (2017) for the inclusion of gabapentin on the WHO Model List of Essential Medicines for the treatment of neuropathic pain. 

## Bibliometric information
Kamerman PR, Finnerup NB, De Lima L, Haroutounian S, Raja SN, Rice ASC, Smith BH, Treede RD. Gabapentin for neuropathic pain: An application to the 21st meeting of the WHO Expert Committee on Selection and Use of Essential Medicines for the inclusion of gabapentin on the WHO Model List of Essential Medicines. DOI: [10.6084/m9.figshare.3814206.v2](http://dx.doi.org/10.6084/m9.figshare.3814206.v2), 2016

## Instructions 

### Download a complete copy

Click on this [link](https://dl.dropboxusercontent.com/u/11805474/painblogr/neuropathic-pain-storyboard-2016/eml-application.pdf) to access a compiled version of the document.

### Build the document

Follow the steps below to compile the application, appendices, and the executive summary.

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
    - ggplot2 2.1.0   
    - scales 0.4.0
    - gridExtra 2.2.1
    - xtable 1.8-2
    - pander 0.6.0
    - readr 1.0.0
    - stringr_1.1.0
    - tidyr 0.6.0
    - tibble 1.2        
    - dplyr 0.5.0
    
## License

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Gabapentin for neuropathic pain: An application to the 21st meeting of the WHO Expert Committee on Selection and Use of Essential Medicines for the inclusion of gabapentin on the WHO Model List of Essential Medicines</span> by the <a href="http://www.iasp-pain.org" target="_blank">International Association for the Study of Pain (IASP)</a> and the <a href="http://hospicecare.com/home/" target="_blank">International Association of Hospice and Palliative Care (IAHPC)</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>. 