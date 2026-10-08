# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ~11.0`).
- The **GraphQL** module (`graphql`).
- The **Key** module (`key`) — used to store the Vertex AI service-account
  credential securely.
- A **Google Cloud Platform** account with a configured **Vertex AI data store**
  and **agent builder**, plus the **service-account authentication file** for
  that project.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_vertex_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in GraphQL and Key if they aren't present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql_vertex_ai -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with GraphQL and Key:

```bash
drush en graphql key graphql_vertex_ai -y
```

## Verify it worked

Confirm the **Administer GraphQL Vertex AI** permission
(`administer graphql_vertex_ai`) appears under **People → Permissions**, and that
the module's settings form loads for an administrator. Full setup — storing the
credential and connecting your Vertex AI data store — is covered in
[Configuration](../configuration/index.md).
