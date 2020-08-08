FROM ubuntu:18.04

# Update the list of products
RUN apt-get update

# Install the software properties common
RUN apt-get install -y software-properties-common wget

# Update the list of products
RUN apt-get update

# Install wget
# RUN apt install -y wget

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

# Intall AzureCLI

RUN apt-get update
RUN apt-get install ca-certificates curl apt-transport-https lsb-release gnupg
RUN apt-get update

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install AzureCLI AKS Kubectl / KubeLogin
RUN az aks install-cli

# Install node.js, NPM and net-tools packages
RUN apt-get update
RUN apt-get install -y nodejs npm net-tools iputils-ping ssh

# Install Google Cloud API
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

# Start PowerShell
CMD pwsh