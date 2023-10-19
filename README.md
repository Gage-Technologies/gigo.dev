<div align="center">
  <img src="images/logo.png" alt="Gigo Logo" width="50" align="left" syle="padding-bottom: 15px;"/>
  <h1>Gigo: Works On Our Machine</h1>
</div>

![Gigo Platform Preview](images/gigo-halloween-screenshot.png)

---

**Gigo** is a one-of-a-kind online learn-to-code platform that provides an integrated learning experience, customized development environments, and a vibrant community to help you take your coding skills to the next level.

---

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [Support](#support)
- [Security](#security)
- [License](#license)

---

## Features

### DevSpaces

- Fully containerized development environments that you can spin up in seconds.
- Pre-configured for various programming languages like Golang, Python, Java, Rust, and TypeScript.
- Built-in support for Docker, Docker Compose, [Web Based VSCode](https://github.com/coder/code-server), and more!

### Open Community

- Submit your own lessons, projects, and tutorials.
- Vote and comment on community contributions.
- Engage with a network of passionate developers.

### Integrated Tutorials in Web-based VSCode

- Learn directly within a web-based VSCode interface.
- Interactive tutorials guide you step-by-step.
- No need to switch between a learning platform and your code editor.

### Remote Desktops

- Full GUI support for complex projects.
- Access your DevSpace from any device.
- Run any application or development tool.

---

## Getting Started

1. **Sign Up**
    - Visit [Gigo](https://gigo.dev) to create an account.
  
2. **Choose a Lesson or Tutorial**
    - Browse through our extensive list of lessons and pick one that interests you.

3. **Launch DevSpace**
    - Start your personalized development environment with a single click.

4. **Start Coding**
    - Follow the interactive tutorials and start coding!

---

## Contributing

We welcome contributions from the community. For guidelines and more information, see [CONTRIBUTING.md](link_to_contributing_guide).

---

## Support

For any issues or queries, reach out to us at [contact@gigo.dev](mailto:contact@gigo.dev) or join our [Discord server](https://discord.gg/2KJKa8AxJg).

---

### Security

If you find a security vulnerability, do not open a Github Issue. Send an email to [sam@gigo.dev](mailto:sam@gigo.dev). The vulnerability will be patched and deployed then we will announce the disclosure and give you proper credt.

---

## License

Gigo is licensed under the [AGPLv3 License](LICENSE).

---

### Attributions

A special thanks to the teams that built some of the foundations for this project. We'll be adding to this list as we complete the OSS effort. This is by no means a complete list.

- Coder: The basis for Gigo's workspace system and much of the core features were inspired by and derived from their work!
  - [Web Based VSCode](https://github.com/coder/code-server): A full web based VSCode editor
  - [Coder v2](https://github.com/coder/coder): On-Prem Cloud Development Environments using Terraform to deploy the craziest environments you can think of

- Tailscale: Tailscale's open source networking software is used to provide secure networking from `gigo-core` servers to DevSpaces provisioned in the cloud!
  - [tailscale](https://github.com/tailscale/tailscale): Secure networking made easy

- Terraform: Terraform is used to provisione resource in kubernets for workspaces (maybe even VM's some day)
  - [terraform](https://github.com/hashicorp/terraform): Terraform enables you to safely and predictably create, change, and improve infrastructure. It is an open source tool that codifies APIs into declarative configuration files that can run anywhere.

- Meilisearch: Meilisearch is used to power search functionality throughout gigo including the main search bar, tag search and so much more
  - [meilisearch](https://github.com/meilisearch/meilisearch): Super fast, lightweight, search engine built in rust

- Gitea: Gitea is the git backend that we use to persist codebases and manage their version across Gigo
  - [gitea](https://github.com/go-gitea/gitea): Git with a cup of tea, painless self-hosting

---

<div align="center">
  <b>Join the Gigo community and elevate your coding skills!</b>
</div>
