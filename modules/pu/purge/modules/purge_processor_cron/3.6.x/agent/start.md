# purge_processor_cron — agent start

Submodule of **purge**. Provides one processor plugin `CronProcessor`
(`Plugin/Purge/Processor/CronProcessor`) that drains the purge queue on every cron run and
hands invalidations to the configured purgers (bounded by the capacity tracker).

Trivial: no config, schema, or permissions — enabling the module registers the processor.
Enable it (and configure purgers/queuers in `purge`) to process invalidations on cron. This
is the recommended default processor. See the `purge` core docs for the pipeline and
`drush p:queue-work` for manual processing.
