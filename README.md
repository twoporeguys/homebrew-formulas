# brew-formulas

Brew formulas for the TPG repositories and tool setup. 

## Configure:
This assumes you are on a mac, have [homebrew](https://brew.sh/) installed and have [GIT access using ssh](https://help.github.com/articles/connecting-to-github-with-ssh/) to [twoporeguys/homebrew-formulas](https://github.com/twoporeguys/homebrew-formulas).

Then, on you type these commands to install things:
'''
    brew tap twoporeguys/homebrew-formulas  # Add TPG formulas to your homebrew
    brew install librpc --with-python3      # Install librpc
    brew install libadcusb --with-python3   
'''

## Run and test
'''
    > ipython
    Python 3.6.3 (default, Oct 20 2017, 16:17:23)
    Type 'copyright', 'credits' or 'license' for more information
    IPython 6.1.0 -- An enhanced Interactive Python. Type '?' for help.
    
    In [1]: import librpc
    In [2]: client = librpc.Client()
    In [3]: client.connect('usb://CharlieAssembly84')
    In [4]: client.call_sync('adc.identify')
'''

## Troubleshooting

### librpc ModuleNotFoundError
Error:
'''
    > ipython
    Python 3.6.2 |Anaconda, Inc.| (default, Sep 21 2017, 18:29:43) 
    Type 'copyright', 'credits' or 'license' for more information
    IPython 6.1.0 -- An enhanced Interactive Python. Type '?' for help.
    
    In [1]: import librpc
    ---------------------------------------------------------------------------
    ModuleNotFoundError                       Traceback (most recent call last)
    <ipython-input-1-d9b6ef89b153> in <module>()
    ----> 1 import librpc
    
    ModuleNotFoundError: No module named 'librpc'
'''