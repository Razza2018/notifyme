# NotifyMe CLI

**NotifyMe** is a lightweight CLI tool for developers to receive push notifications on their phone for long-running commands or scripts. It integrates with the ntfy mobile or web app, supports Linux and macOS, and allows seamless notification workflows in the terminal. It is ideal for build, deploy, or any process where you want real-time updates without constantly checking the terminal.

## Features

* **Single QR code subscription**: Initialize once, scan QR code, and stay subscribed.
* **Default notifications**: Automatically sends messages when a job finishes. Detects the last command executed.
* **Custom notifications**: Send a custom message anytime.
* **Cross-platform**: Works on Linux and macOS.
* **Persistent topics**: Topic saved to `~/.notifyme_topic` so notifications persist across terminal sessions.
* **Easy workflow integration**: Supports chaining multiple commands in a workflow.

## Installation

### Requirements

* `bash` (Linux or macOS)
* `curl`
* `qrencode` (install via package manager)
* ntfy mobile app on your phone or use web app

### Installing qrencode

#### macOS

```bash
brew install qrencode
```

#### Linux (Debian/Ubuntu)

```bash
sudo apt update && sudo apt install qrencode
```

#### Linux (Fedora/RedHat)

```bash
sudo dnf install qrencode
```

### Installing NotifyMe

Simply copy the contents of the [notifyme.sh](./notifyme.sh) function into your `.bashrc` or `.zshrc`:

Then reload your shell:

```bash
source ~/.bashrc  # or ~/.zshrc
```

## Usage

### Initialize subscription (QR code shown once)

```bash
notifyme init
```

* Shows a QR code with a link to subscribe to the topic.

### Send a notification with default message

```bash
notifyme
```

* Uses the last executed command as the message.

### Send a notification with a custom message

```bash
notifyme "Build finished. Deploying to dev"
```

* Sends the provided message.

### Workflow Example

```bash
notifyme init
npm run build:dev
notifyme
cd server && ./deploy dev
notifyme
npm run build:staging
notifyme
```

* Only one QR code scan is required
* Each `notifyme` sends a meaningful notification automatically
