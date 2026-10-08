# State Token — manual setup guide

**State Token** (`state_token`) integrates with the
[Token](https://www.drupal.org/project/token) module to expose values from the
current request and state as tokens. That lets you reference request/state context
— current values from the running request — wherever tokens are supported in
Drupal configuration and text. It works across Drupal 9, 10, and 11.

This is a developer and site-building convenience. The tokens it provides resolve
against request/state data at render time; the module has no content model and no
access-control role of its own. There is nothing to configure through a UI — you
enable it and then use its tokens anywhere Drupal accepts tokens.

At the time of writing the module is a beta release, so test it in your context
before depending on it in production.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling, the module's state/request tokens become available wherever
Drupal's token system is offered — for example in fields, text formats, and module
configuration that supports token replacement. Use the token browser (provided by
the Token module) to discover the available tokens, then insert them where you need
a request/state value substituted in. There is no admin settings page.
