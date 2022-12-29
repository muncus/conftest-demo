# Demo: Using Conftest to create consistency across a large organization

Conftest (http://conftest.dev) can be used to add lightweight "validation" on
many kinds of structured data. These types of validations are critical for large
organizations, where Best Practices(tm) often change over time - making
consistent enforcement difficult.

This repo provides a demo of centrally-controlled policy, that is evaluated
against various data with Github Actions. The actions/workflow are written such
that they can be used in external repositories (or across all repositories in an
org!).

