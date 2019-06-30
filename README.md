# GitHubBackup
Simple UI for bulk downloading GitHub repositories

## IMPORTANT NOTE

This project is currently under active development, and is not a complete solution yet. It is however fully functional in its current state for what it needs to do. There are many improvements which are being worked on at this time, and the internal structure will undergo complete revisions.

## Summary

This project allows for a very simple download of multiple repositories at once from any given user or organization. Simply fetch a list of all repositories, place a check by the ones you want, and click "Download" to get them all at once.

## OpenSSL

This project requires the OpenSSL binaries. These are not included in this repository, and you are responsible to provide a 32bit set of binaries with the output executable. Specifically, `ssleay32.dll` and `libeay32.dll`. 

## Setup

To use this tool, you will need to first obtain a personal access token for your GitHub account. When first opening the application, you will be required to enter this token in the setup. You will also need to select a directory where you want your repositories downloaded to, as well as enter the account name of the user or organization you need to work with.

### Obtaining Access Token

You can create your own personal access token by visiting your [Developer Settings](https://github.com/settings/tokens). Enter this token into the "Access Token" field in the app's setup screen. 

### Account Name

This app supports either user accounts or organization accounts. Enter the unique account name into the setup, and then choose whether it's a `User` or an `Organization`. 

### Backup Directory

You need to choose the folder on your local computer where you want to download your repositories to. Either type that directory into the "Backup Directory" field, or click the browse button to the right of it. The app will validate the directory you choose before allowing you to continue.

## Listing Repositories

The main screen allows you to fetch a list of all the repositories the chosen access token allows you to see in the chosen account. It describes various attributes about each repository. 

## Downloading Repositories

To the left of each list item, you can place a check next to each repository you wish to download, or you can select all. By clicking the main "Download" button, you initiate the bulk download of all the checked repositories. 
