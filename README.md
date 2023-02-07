# Demo: Using Conftest to create consistency across a large organization

Conftest (http://conftest.dev) can be used to add lightweight "validation" on
many kinds of structured data. These types of validations are critical for large
organizations, where Best Practices(tm) often change over time - making
consistent enforcement difficult.

This repo shows how an organization might use conftest to validate a variety of
checks across different repositories using github actions.

The Workflows and Actions provided here are provided as a demonstration. The
Action will need to be hosted in its own repository in order to be reusable by
other repositories, as described in [About Custom
Actions](https://docs.github.com/en/actions/creating-actions/about-custom-actions#choosing-a-location-for-your-action) in the GHA docs.

