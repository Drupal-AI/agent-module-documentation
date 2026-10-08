# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **User** (`user`) and **Views** (`views`) modules.
- The **Group** module (`group:group`, `^3.2`) — this is the foundation LMS is
  built on (a course is a group), so it is essential rather than optional. Composer
  pulls it in with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/lms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install the
Group dependency alongside LMS.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lms -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lms -y
```

If you are upgrading from the 1.1 branch, run database updates afterwards
(`drush updb -y`): the 1.2 branch adds revision-aware reference fields and back-fills
existing courses, lessons, activities and progress with their current revisions, then
removes the legacy fields.

## Submodules — enable what you need

LMS ships three submodules that most sites will want. Enable them individually
with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Answer Plugins** | `lms_answer_plugins` | The basic Activity/Answer plugin set — i.e. the built-in question types. This is what makes activities usable, and it is the extension point for building a custom question type. Most sites should enable this. |
| **Answer Comments** | `lms_answer_comments` | Lets teachers and students comment on submitted answers — this is how the feedback loop works. |
| **Classes** | `lms_classes` | Organises students into classes, for running the same course with several cohorts; adds *add students* / *view students* group permissions. |

For example, to add the built-in question types:

```bash
drush en lms_answer_plugins -y
```

Each submodule requires the base LMS module, which is already present once you
have installed it above.

## The wider ecosystem

Beyond these submodules, separate projects extend LMS with certificates
(`lms_certificate`), file-upload and webform activities (`lms_file_upload`,
`lms_webform`), SCORM and H5P and xAPI support (`lms_scorm`, `lms_h5p`,
`lms_xapi`), event notifications (`lms_messages`), AI features (`lms_ai`), and an
enrolment approval gate (`lms_membership_request`). Install those separately as
your site needs them.

## Verify it worked

After enabling LMS (and `lms_answer_plugins`), the LMS entity types and
permissions are available — check **People → Permissions** for the `administer
lms` and per-entity create/use permissions, and **Administration → LMS →
Settings** for the general settings form. From there, follow the
[How to use it](../index.md#how-to-use-it) steps to build your first course.
