# Configuration

Reporter is configured entirely through its **report editor** — the place where
you name a report, describe it, and provide the SQL that generates it. Each report
you define becomes a re-runnable tabular report with its own URL. When you enable
the module it already contains a few **example reports** you can study, edit, or
delete.

## Before you start: who should have access

Reports run **SQL you write** directly against the site database. That makes
report authoring a highly privileged action — a report can read any table and
expose sensitive data. Only grant access to the report editor to **trusted
administrators**, and when you design a report, make sure its columns and rows do
not reveal data beyond what the people viewing it are allowed to see.

## Open the report editor

Log in as an administrator and go to Reporter's **configuration editor** (the
report-management screen the module adds under the admin configuration area).
There you will find the list of existing reports, including the shipped examples.

## Create or edit a report

Each report is defined by three things:

- **Report name** — the human-readable title for the report. This identifies it in
  the reports listing and is used to build the report's own URL.
- **Report description** — a short explanation of what the report shows. Use it to
  remind yourself (and other admins) of the report's purpose and any caveats about
  its data.
- **SQL** — the query that produces the report. Reporter runs this query and
  renders the returned rows and columns as the tabular report. Write it carefully:
  it executes against your live database, so test on non-production first and
  avoid queries that could expose sensitive fields or place heavy load on the
  database.

Fill in these fields and save. Reporter turns the definition into a finished
report available at its own URL.

## Managing reports

From the editor you can **add** new reports, **modify** existing ones, or
**delete** any you no longer need — including the canned examples that ship with
the module. Deleting the examples once you understand them is a good way to keep
the reports listing focused on your own reports.

## Viewing reports

Reporter also provides a **listing page** that shows all your defined reports so
you (and other permitted users) can open and view each one. Because each report
re-runs its SQL when viewed, the results always reflect current data.
