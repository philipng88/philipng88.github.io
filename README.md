# Country Helper
## macOS X Usage
1. Download [CountryHelper.sh](https://philipng88.github.io/CountryHelper.sh)
2. Install the **Homebrew package manager** with the following command: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"` 
    - If you already have Homebrew installed, you may skip to step 3
3. Install the [jq command line JSON processor](https://stedolan.github.io/jq): `brew install jq`
4. You will likely need to upgrade your bash shell. Do this by using `brew install bash`
5. Close and reopen the terminal
6. Navigate to the folder/directory where *CountryHelper.sh* is located
    - e.g., `cd ~/Downloads` if your browser automatically places downloaded files into your downloads folder
7. Use `chmod +x CountryHelper.sh` to ensure that the script has executable permissions
8. Run the script with `bash CountryHelper.sh`
9. If you run into problems using the script, you may need to take some additional actions with the new bash shell you installed in step 4. Please refer to the following article for help: [Upgrading Bash on macOS](https://itnext.io/upgrading-bash-on-macos-7138bd1066ba) 

## Windows Usage
If you do not have the Bash shell installed on your Windows machine, you will need to install it in order to run the Country Helper script. There are a few ways to do this and I recommend installing either **Git Bash** or **Bash [on Ubuntu] on Windows**. In either case, you will first need to install the [jq command line JSON processor](https://stedolan.github.io/jq)
### Installing jq
1. Open the **Command Prompt** and run as an administrator. You can do this by right-clicking on the Windows start button (or pressing Windows+X) and selecting Command Prompt (Admin)
2. Install the **Chocolatey Package Manager** with the following command: `@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"`
3. Close and reopen the Command Prompt (running as administrator)
4. Install **jq** with `chocolatey install jq`
### Using with Git Bash
1. Download [CountryHelper.sh](https://philipng88.github.io/CountryHelper.sh)
2. Read and follow through with the instructions in [this article](https://learn.adafruit.com/an-introduction-to-collaborating-with-version-control/windows) to install Git Bash
3. Open Git Bash
4. Navigate to the folder/directory where *CountryHelper.sh* is located
    - e.g., `cd ~/Downloads` if your browser automatically places downloaded files into your downloads folder 
5. Use `chmod +x CountryHelper.sh` to ensure that the script has executable permissions
7. Run the script with `bash CountryHelper.sh`
### Using with Bash on Windows
1. Download [CountryHelper.sh](https://philipng88.github.io/CountryHelper.sh)
2. Read through and follow the instructions in [this article](https://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10) (up until you have finished setting your UNIX username and password)
3. Run `sudo apt update && sudo apt upgrade` 
    - This will take a while. Be patient!
4. You can now exit out of Ubuntu if you would like. As you will see in the final steps, we can use bash commands in Command Prompt with *bash -c "command"*
5. Open the Command Prompt 
6. Navigate to the folder/directory where *CountryHelper.sh* is located
    - e.g., `cd ~/Downloads` if your browser automatically places downloaded files into your downloads folder 
7. Use `bash -c "chmod +x CountryHelper.sh"` to ensure that the script has executable permissions
8. Run the script with `bash -c "bash CountryHelper.sh"`

## Linux Usage
1. Download [CountryHelper.sh](https://philipng88.github.io/CountryHelper.sh)
2. Open the terminal
3. Navigate to the folder/directory where *CountryHelper.sh* is located
    - e.g., `cd ~/Downloads` if your browser automatically places downloaded files into your downloads folder 
4. Use `chmod +x CountryHelper.sh` to ensure that the script has executable permissions
5. Run the script with `bash CountryHelper.sh`
    - note: The Country Helper script will detect your linux distribution and run the necessary command(s) to install the jq command line JSON processor [if not already installed]. However, if you prefer to install jq yourself, refer to the [jq website](https://stedolan.github.io/jq) 