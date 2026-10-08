# Config Patch GitLab API — manual setup guide

**Config Patch GitLab API** (`config_patch_gitlab_api`) is an *output plugin* for the
[Config Patch](https://www.drupal.org/project/config_patch) module. Config Patch takes the
configuration changes you have made live in the admin UI and turns them into a patch; this
plugin delivers that patch to **GitLab** — creating a branch on any GitLab instance and
pushing the change to it, so a config edit made through forms arrives in your repository as
reviewable code.

The result is a review workflow that matches how the rest of your codebase is handled: a
site builder changes a setting, the patch appears as a branch, a developer opens a merge
request, and the change is reviewed and deployed rather than discovered later in a stray
diff. The plugin lets you pick the target project (with autocomplete), choose the source and
new branch names, write a commit message, push, and then follow a link straight to the merge
request. It works against self‑hosted GitLab as well as gitlab.com.

It requires **Config Patch** and Drupal `^10 || ^11`, and it provides a restricted
permission, `administer config_patch_gitlab_api`, for who may configure the GitLab
connection.

> **Two warnings, up front.**
>
> **This release is an alpha (3.0.0‑alpha3) on a feature that writes to your repository.**
> Test it against a scratch project before pointing it at anything important.
>
> **The GitLab credential is a powerful, sensitive token.** It is a project access token
> with `api` and `write_repository` scopes — it can push to your repository — and the way
> the credentials form handles it means the live token can be visible to anyone who can open
> that form, and it lands in configuration exports and database dumps. Read the
> [Configuration](configuration/index.md) page's security section before you enter it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (Config
   Patch first).
2. [Configuration](configuration/index.md) — enter the GitLab credentials, store the token
   safely, and pick the target project and branch.

## Where it lives in the admin menu

The GitLab credentials form is the module's configuration entry point
(`config_patch_gitlab_api.credentials`), reachable by users with the restricted
**Administer config patch GitLab API** permission. The actual "create a branch and push"
action is driven from Config Patch's own workflow, where you choose this GitLab plugin as
the output for a patch.
