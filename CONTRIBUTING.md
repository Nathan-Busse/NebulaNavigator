# Contributing

Hi there! We're excited you have ideas to improve topics and collections. You're helping the community discover valuable information.

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

There are a few ways you can contribute:

- Improving an existing topic or collection
- Curating a new topic or collection

As you write content, check out the [Style Guide](./docs/styleguide.md) to learn what each field means, and how it should be formatted. Following the style guide will increase the chances of your contribution being accepted.

Notes:

- Updates won't immediately appear once we've merged your PR. We pull in these changes regularly to GitHub.
- Please limit your pull request to the creation/updating of one topic or collection at a time.

## Improving an existing topic or collection

If a topic or collection already exists, it will be listed in its respective directory:

- [topics/](https://github.com/github/explore/tree/main/topics)
- [collections/](https://github.com/github/explore/tree/main/collections)

The topic or collection name should match its URL, e.g. `https://github.com/topics/rails` corresponds to the [`topics/rails` directory](https://github.com/github/explore/tree/main/topics/rails).

To make an improvement, please **open a pull request** with your proposed changes. 

### Update the image

To update the image, simply replace the image inside the directory for the topic or collection.

### Update text and links

To update text and links, edit the `index.md` inside the topic or collection's directory. These files are formatted using a combination of [Front Matter](https://jekyllrb.com/docs/frontmatter/) and simple body content.

For **topics**, you'll notice that, in examples like the topic "[algorithm](https://raw.githubusercontent.com/github/explore/main/topics/algorithm/index.md)," data like its canonical URL, Wikipedia URL, or display name are called out in key-value pairs, while its detailed description is accounted for in the body of the document.

_/topics/algorithm/index.md_:

```markdown
---
aliases: algorithms
display_name: Algorithm
short_description: Algorithms are self-contained sequences that carry out a variety of tasks.
topic: algorithm
wikipedia_url: https://en.wikipedia.org/wiki/Algorithm
---
Algorithms are detailed sets of guidelines created for a computer program to complete tasks efficiently and thoroughly.
```

---

Similarly, **collections** like "[music](https://raw.githubusercontent.com/github/explore/main/collections/music/index.md)" call out things like their author and display name in Front Matter variables -- with a detailed description in the body of the document. Most importantly, though, collections identify their individual collection items in [a YAML list](https://en.wikipedia.org/wiki/YAML#Basic_components) for the key "items."

_/collections/music/index.md_:

```markdown
---
items:
 - beetbox/beets
 - scottschiller/SoundManager2
 - CreateJS/SoundJS
 - musescore/MuseScore
 - tomahawk-player/tomahawk
 - cashmusic/platform
 - mopidy/mopidy
 - AudioKit/AudioKit
 - Soundnode/soundnode-app
 - gillesdemey/Cumulus
 - metabrainz/picard
 - overtone/overtone
 - samaaron/sonic-pi
display_name: Music
created_by: jonrohan
---
Drop the code bass with these musically themed repositories.
```

---

The [pull request template](./.github/PULL_REQUEST_TEMPLATE.md) also provides guidance on the information you need to include.

**Please fill out the pull request template completely,** if you do not fill out the template, your PR will be closed.

## Curating a new topic or collection

If a topic or collection is not yet curated, it will NOT be listed in its respective directory.

We are likely to consider suggestions to curate a topic or collection that is valuable to GitHub's community. Valuable topics, for example, include those that are already [widely used by repositories](https://help.github.com/articles/classifying-your-repository-with-topics/) and could benefit from the addition of important information. When suggesting content, please consider how to make your contribution broadly useful and relevant to others, rather than serving a specific use case.

Please note that all suggestions must adhere to GitHub's [Community Guidelines](https://help.github.com/articles/github-community-guidelines/) and [Terms of Service](https://help.github.com/articles/github-terms-of-service/). Per our Terms of Service, [you are responsible](https://help.github.com/articles/github-terms-of-service/#d-user-generated-content) for the content you contribute, and you must have the rights to use it.

To propose a new topic or collection, please **open a pull request** with your proposed additions. The [API docs](./docs/API.md) and [style guide](./docs/styleguide.md) provide guidance on the information you need to include and how it should be formatted.

This repository includes [a list of the most-used GitHub topics that don't yet have extra context](topics-todo.md). If your pull request adds one of these topics, please update topics-todo.md so that the topic is checked (marked complete).

**Please fill out the pull request template completely.** If you do not fill out the template, your pull request will be closed.

## Guidelines

- Avoid conflicts of interest. These should be of general community interest, not a marketing vehicle for a product or a personal project. If you are a direct employee of a company creating the project, or the creator and sole maintainer, it's unlikely to be accepted.
- We love experimenting with new technologies, and we are especially fond of GitHub Copilot. But as with all new technology, many of us are still getting accustomed to using generative AI tools effectively. Here are important guidelines to follow when using generative AI to contribute to this repository (adapted from the [GitHub Community Discussions CoC](https://github.com/community/community/blob/main/CODE_OF_CONDUCT.md#reasonable-use-of-ai-generated-content)):
  - Read and revise the content before you post it. Use your own authentic voice and edit.
  - Do not post AI-generated content verbatim to pad out the size and number of your contributions. Your changes should materially improve the site, not just say the same thing in different words.
  - AI tools will often provide completely inaccurate or invented answers to prompts. Verify with an independent source that the information is correct before including it.

## Running tests

There are some lint tests in place to ensure each topic is formatted in the way we expect. GitHub
Actions will run the tests automatically. If you want to run the tests yourself locally, you will
need Ruby and Bundler installed.

You can run the tests using:

```bash
bundle install
bundle exec rubocop
```

---

# Contributing to Nebula Navigator

Thank you for your interest in contributing to Nebula Navigator! Your support helps make this project better and more impactful. Below are the guidelines for contributing to the repository.

---

## Table of Contents
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
  - [Reporting Issues](#reporting-issues)
  - [Suggesting Enhancements](#suggesting-enhancements)
  - [Submitting Code Changes](#submitting-code-changes)
- [Code of Conduct](#code-of-conduct)
- [Development Guidelines](#development-guidelines)
- [License](#license)
- [Contact](#contact)

---

## Getting Started

To get started:
1. Clone the repository:
   ```bash
   git clone https://github.com/Nathan-Busse/NebulaNavigator.git
   cd NebulaNavigator
   ```
2. Familiarize yourself with the project by reading the [README.md](README.md), [architecture.md](docs/architecture.md), and [roadmap.md](docs/roadmap.md).

3. Set up the environment:
   - Follow the instructions in the `Installation & Setup` section of the `README.md`.

---

## How to Contribute

### Reporting Issues
If you find any bugs or issues:
- **Check for Existing Issues:** Search the [issues section](https://github.com/Nathan-Busse/NebulaNavigator/issues) to see if the issue is already reported.
- **Create a New Issue:**  
  - Describe the problem clearly.
  - Include steps to reproduce the issue.
  - Attach relevant logs, screenshots, or system details if possible.

### Suggesting Enhancements
Have a great idea for improving Nebula Navigator? Here's how:
- Open a new issue labeled as **enhancement**.
- Describe your suggestion in detail:
  - Why is it needed?  
  - How would it benefit users or developers?
  - Include any technical or design considerations.

### Submitting Code Changes
If you'd like to submit changes:
1. **Fork the Repository:**  
   Create your own fork of the repository to work on changes safely.
2. **Create a Feature Branch:**  
   Use a descriptive name:
   ```bash
   git checkout -b feature-your-description
   ```
3. **Write Clear, Documented Code:**  
   Ensure code is readable, clean, and includes comments where necessary.
4. **Test Your Changes:**  
   Run tests locally to verify functionality across both backend and frontend components.
5. **Submit a Pull Request:**  
   - Ensure your PR is clear and concise.
   - Include a description of the changes and their benefits.
   - Reference any related issues.

---

## Code of Conduct

Nebula Navigator is committed to fostering a welcoming and collaborative environment. By participating, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md), which outlines expectations for respectful communication and constructive collaboration.

---

## Development Guidelines

To ensure quality and consistency:
1. **Follow the Coding Style:**  
   - Backend: Python code should follow PEP 8 standards.  
   - Frontend: Use modern JavaScript practices and keep styling responsive.
2. **Commit Message Guidelines:**  
   - Write clear, concise messages that explain the purpose of the commit.  
   - Start with an action verb (e.g., "Fix," "Add," "Update").
   - Example: `Fix: Resolve error in Perlin noise generation module`.
3. **Testing:**  
   - Include unit tests for backend modules and frontend components.
   - Test changes across multiple browsers and environments.

---

## License

By contributing, you agree that your submissions are licensed under the [Nebula Navigator Professional License (NNPL)](LICENSE). Please review the license terms before submitting contributions.

---

## Contact

For any questions or additional guidance:
- **Email:** bussenathan@icloud.com
- **GitHub:** [Nathan Busse](https://github.com/Nathan-Busse)

Thank you for your contributions and support in making Nebula Navigator extraordinary!

---

