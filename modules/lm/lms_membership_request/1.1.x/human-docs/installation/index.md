# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **LMS Classes** submodule (`lms_classes`) of the LMS module — this is the
  direct dependency.
- The **Group Membership Request** module — the request/approval mechanism this
  builds on (courses are Groups in LMS).

## Install with Composer

From the project root:

```bash
composer require drupal/lms_membership_request -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
LMS (and LMS Classes) dependency alongside it. Install the Group Membership
Request module the same way if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lms_membership_request -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure **LMS Classes** and **Group Membership Request** are enabled, then:

```bash
drush en lms_membership_request -y
```

## Verify it worked

Mark a test course as requiring membership validation, then, as a non-member,
request membership on it and confirm an approver has to validate the request
before enrolment completes. See [How to use it](../index.md#how-to-use-it) for the
full flow.

> **Note:** This is a **1.1.0-beta4** release and the project is minimally
> maintained. Test it on a non‑production environment first.
