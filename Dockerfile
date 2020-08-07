FROM ubuntu:18.04

# Update the list of products
RUN apt-get update

# Install the software properties common
RUN apt-get install -y software-properties-common

# Update the list of products
RUN apt-get update

# Install wget
RUN apt install -y wget

# Download the Microsoft repository GPG keys
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
RUN dpkg -i packages-microsoft-prod.deb

# Update the list of products
RUN apt-get update

# Enable the "universe" repositories
RUN add-apt-repository universe

RUN apt-get update

# Install PowerShell
RUN apt-get install -y powershell

# Install PowerShell Modules

RUN pwsh -command Install-Module -Name PSWindowsUpdate -Force
RUN pwsh -command Install-Module -Name Az -Force
RUN pwsh -command Install-Module -name MSOnline -Force
RUN pwsh -command Install-Module -Name AzureAD -Force
RUN pwsh -command Install-Module -Name MicrosoftTeams -Force

# Start PowerShell
CMD pwsh