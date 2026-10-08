# Configuration

Permissions by Term has three moving parts you configure: the **settings form**
(the overall access model), the **term edit form** (which users and roles may
use a term), and the **user edit form** (which terms a user may access). This
page covers all three, plus how to rebuild access after big changes.

## Granting a term to users and roles

This is the core of the module. Grants are set on the **taxonomy term edit
form**:

1. Go to **Structure → Taxonomy**, choose a vocabulary, and edit the term you
   want to restrict.
2. Open the **Permissions** section on the form. It has two controls:
   - **Allowed users** — an autocomplete field where you enter one or more
     specific accounts (comma-separated) who may access content tagged with this
     term.
   - **Allowed roles** — checkboxes for the roles who may access content tagged
     with this term.
3. Save the term.

From then on, any node that references this term is visible only to the listed
users and roles (plus site administrators). Content that references *no*
restricted terms is unaffected, unless you switch on permission mode (below).

> **Note:** when you grant a term to any role, the module also automatically
> grants it to every role that has the core *Bypass node access* permission
> (typically Administrator), so administrators never lock themselves out.

### Granting from the user side

You can also work the other way round, from a person's account. On the **user
edit form**, a **Permissions → Vocabularies** section lets you select, per
vocabulary, which terms that user may access. This is convenient when you are
setting up a single new user who should see several restricted sections.

## The settings form

Go to **Configuration → System → Permissions by Term**
(`/admin/permissions-by-term/settings`). The options are:

- **Permission mode** — off by default. When on, the module switches to
  "whitelist" behaviour: a node is only accessible if one of its terms
  *explicitly* grants it. This means nodes with no terms at all (or with terms
  that grant nobody) become hidden by default. Use it when you want everything
  locked down unless deliberately opened up.

- **Require all terms granted** — off by default. When on, a user must be granted
  *every* restricted term on a node to see it, rather than just one of them. Turn
  it on for stricter, "must match all" access.

- **Disable node access records** — off by default. Node access records are what
  make restricted content also disappear from Views listings, menus, search and
  `/admin/content`. Turning them off restricts only direct node view/edit, and is
  a significant performance win on very large listings — but restricted content
  will then still appear in listings. Toggling this rebuilds node access.

- **Show only parent terms** — when on, the user-form term selector shows only
  top-level terms, which keeps the form manageable for vocabularies with hundreds
  of children.

- **Target bundles (vocabularies)** — choose which vocabularies the module
  manages. Leaving it empty means "all vocabularies". **Be careful:** unchecking a
  vocabulary here *deletes* the term permissions already stored for that
  vocabulary.

- **Show terms in user form** — controls whether the *Permissions → Vocabularies*
  selector appears on the user edit form. On by default.

- **Hide permissions info in node form** — hides the read-only "Permissions by
  Term" panel that otherwise appears in the node form's sidebar, saving a little
  load time.

Click **Save configuration** to apply. After changing **Permission mode** or
**Disable node access records**, it is good practice to rebuild node access (see
below).

## Rebuilding access after bulk changes

Grants are cached and mirrored into Drupal's node access system, so large changes
(a bulk content import, editing grants directly in the database, or changing the
settings above) may need a rebuild to take full effect. Run:

```bash
drush permissions-by-term:rebuild   # short alias: pbtr
```

There is also a helper to generate test content with permissions applied, useful
for load testing:

```bash
drush permissions-by-term:create-nodes-with-permissions 1000
```

## Automatic cleanup

You do not need to tidy grants by hand in the usual cases: when a user account is
cancelled, that user's grants are removed automatically, and when a taxonomy term
is deleted, all grants for that term are removed too.
