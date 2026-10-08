<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN MCP Server — tool surface

Built on `mcp_server`; this module contributes `#[Tool]` plugins under `src/Plugin/Tool/` (and read/query tools in the bundled `dkan_query_tools`). Each tool implements `checkAccess(AccountInterface)`.

## Read tools (permission: `access mcp server`)
GetCatalog, GetDataset(Info), GetDistribution, GetDataDictionary, GetSchema, ListDatasets, ListDistributions, ListSchemas, SearchDatasets, SearchColumns; datastore: QueryDatastore, QueryDatastoreJoin, DistinctValues, SampleRows, GetDatastoreSchema/Stats, GetImportStatus; harvest read: GetHarvestPlan/Runs/RunResult, ListHarvestPlans; status: GetSiteStatus, GetQueueStatus.

## Write tools (each its own permission)
- `edit datasets via mcp` → PatchDataset, UpdateDataset
- `publish datasets via mcp` → PublishDataset, UnpublishDataset
- `delete datasets via mcp` → DeleteDataset
- `manage metastore items via mcp` → PostMetastoreItem, PatchMetastoreItem, DeleteMetastoreItem
- `import datastore via mcp` → ImportResource
- `drop datastore via mcp` → DropDatastore
- `manage harvests via mcp` → RegisterHarvest, RunHarvest, DeregisterHarvest

## Prompts
Shipped `mcp_prompt_config` items: find_datasets, explore_dataset, build_datastore_query, dataset_health_check, diagnose_harvest.
