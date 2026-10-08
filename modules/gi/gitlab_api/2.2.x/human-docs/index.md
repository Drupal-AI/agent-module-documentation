# GitLab API — manual setup guide

**GitLab API** (`gitlab_api`) connects your Drupal site to **GitLab** through the
**GitLab REST API (version 4)**. Once configured, code on your site can reach any
GitLab resource through simple calls — for example:

```php
$api = \Drupal::service('gitlab_api.api');
$groups = $api->getClient()->groups();
```

It's built on the well‑known **GitLab PHP client** and dynamically exposes all of
that library's methods through the module's API service, so the full GitLab API
(projects, issues, pipelines, groups, and more) is available.

You can define as many **GitLab server profiles** as you like — each one is a
config entity describing a GitLab instance and its access token — so a single
Drupal site can talk to several GitLab instances at once. The module also ships a
**webform handler** plugin that can create a new GitLab project from a webform
submission, and there is optional ECA integration for driving the API from ECA
models.

A couple of things to keep in mind. If you point it at Drupal's own GitLab at
`git.drupalcode.org`, your access may be limited by that instance's permissions.
And on the security side: the module authenticates with a **GitLab access
token** — store it as a secret, give it the **minimum scopes** it needs, and
operate over HTTPS. A broad token has a large blast radius if it leaks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (which brings in the GitLab PHP client) and enable it.
2. [Configuration](configuration/index.md) — create a GitLab server profile and
   store its access token safely.

## Where it lives in the admin menu

GitLab server profiles are managed at the **GitLab server** collection page (the
`entity.gitlab_server.collection` route), reachable from the module's *Configure*
link on **Extend** or under **Configuration → Web services**. That's where you add,
edit, and delete the server profiles the API service uses.

## How to use it

1. Create a **GitLab server** profile pointing at your GitLab instance and holding
   an access token (see [Configuration](configuration/index.md)).
2. From code or the provided plugins, use the `gitlab_api.api` service (and its
   client) to call GitLab. The webform handler and optional ECA integration let
   you drive the API without custom code.
