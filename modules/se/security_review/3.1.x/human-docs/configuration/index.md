# Configuration

Security Review has two screens: a **Run & review** page where you run the checklist
and read the results, and a **Settings** page where you tell it which roles are
untrusted and which checks to skip. Both require the **Access security review list**
permission; running checks also requires **Run security checks**.

Remember throughout: this module **reports** problems, it does not fix them. Every fail
is something for you to act on manually.

## Run and review the checklist

Go to **Reports → Security Review** (`/admin/reports/security-review`) and run the
checklist. Each check comes back as **pass**, **fail**, **warning**, or **info**. From
this page you can open a check's **Help** to understand what it inspects and why, and
you can **skip** or **re-enable** an individual check — but only after it has been run at
least once.

The checklist covers areas such as:

- error reporting writing errors to the screen (information disclosure),
- the private files directory being inside the web root,
- PHP being executable from the public files directory,
- input/text formats usable by untrusted roles that allow unsafe HTML,
- dangerous permissions granted to untrusted roles,
- overly permissive file/directory permissions,
- `trusted_host_patterns` not being set,
- dangerous allowed upload extensions,
- a leftover user literally named "admin",
- Views left open to untrusted users,
- missing HTTP security headers,
- the Composer vendor directory being web-accessible,

and more.

## Settings

Open **Configuration → Security → Security Review** (`/admin/config/security-review`).

### Untrusted roles

Most checks only flag a resource if it's reachable by an **untrusted** user, so this is
the most important setting. Choose which roles count as untrusted — **Anonymous** and
**Authenticated** are selected by default. If, for example, every authenticated user on
your site is a trusted staff member, you might remove Authenticated so the checklist
stops flagging things only they can reach.

### Logging

Turn on **logging** to record every check run to the log (watchdog), useful for audit
trails. It's off by default.

### Skipping and hushing checks

Checks you've reviewed and decided don't apply to your site can be **skipped** so they
no longer fail the run. Some checks go finer-grained and let you **hush** specific
findings — ignore a particular file in the file-permissions check, a specific view, an
upload extension, a field, or a named HTTP header — without disabling the whole check.
These options appear per-check on the settings form once the checks have run.

All of this (untrusted roles, logging, skipped checks, hushed findings) is stored as
configuration, so it exports and deploys with `drush config:export` /
`drush config:import`. The check *results* themselves are stored in state, not config.

## The Status report entry

Security Review adds an entry to the site's **Status report** (**Reports → Status
report**) that warns administrators when any non-skipped check has failed or when the
checklist has never been run — a passive nudge to keep the review current.

## Running from the command line (`drush secrev`)

For automation and CI pipelines, run the checklist headlessly:

```bash
drush secrev                 # run all checks and print the results
drush secrev --store         # run, store the results, and print
drush secrev --lastrun       # print the last stored results without re-running
drush secrev --results       # include the offending findings for failed checks
```

Scope a run with `--check=error_reporting,trusted_hosts` to run only those checks, or
`--skip=file_permissions` to exclude some (`--skip` wins over `--check`). The command
**exits non-zero if any check fails**, which makes it a natural gate in a deployment
pipeline. Add `--log` to log each check, or `--short` for terse output.
