# purge_processor_lateruntime — agent start

Submodule of **purge**. Provides a processor plugin `LateRuntimeProcessor`
(`Plugin/Purge/Processor/LateRuntimeProcessor`) plus an event subscriber
(`EventSubscriber/LateRuntimeProcessor`, registered in `purge_processor_lateruntime.services.yml`)
that drains a capacity-limited chunk of the purge queue late in every request — near-instant
invalidation. Recommended only for high-latency setups; often used alongside the cron processor.

Trivial: no config, schema, or permissions. Enable it (with purgers/queuers configured in
`purge`) to process invalidations per request. See `purge` core docs for the pipeline.
