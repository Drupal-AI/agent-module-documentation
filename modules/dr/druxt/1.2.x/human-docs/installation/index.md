# Installation

DruxtJS has two halves: a Drupal module (covered here) and a Nuxt.js front end
(set up in your JavaScript project). This page covers the Drupal side and points
you to the Nuxt step.

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **JSON:API** module enabled (the back‑end API the front end reads).
- The **Decoupled Router** module (`decoupled_router`) — Druxt's one module
  dependency. Composer pulls it in with the command below.
- A **Nuxt.js** application on the front end using the `druxt-site` npm package.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/druxt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (including Decoupled Router) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/druxt -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en druxt -y
```

Drupal enables Decoupled Router alongside it. Make sure core's **JSON:API**
module is on as well.

## Grant the Druxt permission

Druxt ships a single read‑only permission. At **People → Permissions**
(`/admin/people/permissions`), grant **Access Druxt resources** to the role your
front end uses. If the Nuxt app reads only public content unauthenticated, grant
it to the anonymous role; if it authenticates, grant it to that role instead.

> **Review access first.** What the front end can read is governed by JSON:API's
> access control and your resource configuration, not by Druxt. Confirm your
> JSON:API/resource setup does not expose unpublished or restricted content and
> fields before opening the API to a front end.

## Connect the Nuxt front end

In your Nuxt project:

```bash
npm i druxt-site
```

Then register the module and point it at your Drupal site in `nuxt.config.js`:

```js
module.exports = {
  modules: ['druxt-site'],
  druxt: {
    baseUrl: 'https://your-drupal-site.example',
  },
}
```

## Verify it worked

With the module enabled and the permission granted, request a JSON:API endpoint
(for example `/jsonapi`) as the front‑end role and confirm you receive the
expected resources. Then start your Nuxt app and confirm it renders content
served from Drupal.
