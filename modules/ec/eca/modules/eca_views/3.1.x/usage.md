ECA Views lets ECA models run Views queries, iterate their results, adjust exposed filters, and export result sets — bringing the power of Views into automated workflows.

---

This submodule integrates core Views with ECA. It provides an event tied to Views execution and actions that execute a View's query and make its rows available to the model, set or override a View's filter values before running, substitute query arguments, and export the results (e.g. to a data structure or file). This means a model can select content with a configured View and then act on each row — process, notify, transform, or export — instead of hand-writing entity queries. It pairs naturally with eca_base list actions and eca_content entity actions to build reporting, batch-processing, and data-export automations. It depends on core Views and registers into ECA Core's managers, defining no new plugin types.

---

- Run a configured View's query from a model.
- Iterate over View result rows in a workflow.
- Process each result row (update, notify, transform).
- Export View results to a data structure or file.
- Set or override a View's exposed filter before running.
- Substitute contextual/query arguments dynamically.
- Build reports by querying content with a View.
- Batch-process entities selected by a View.
- Generate a CSV/data export on a schedule (with cron event).
- Feed View results into other ECA actions.
- Select content by complex criteria without custom queries.
- Send digest emails built from View results.
- Archive or clean up entities matched by a View.
- Drive integrations with data pulled from a View.
- Reuse existing Views as workflow data sources.
- Filter results per current user or context.
- Count or summarize View results in a model.
- Combine View rows with list operations from eca_base.
- Trigger follow-up actions per matched item.
- Deploy Views-driven automations as configuration.
