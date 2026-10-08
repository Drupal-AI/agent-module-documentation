# Configuration

Node Revision Limit needs one quick setup step: telling it how many revisions to
keep. Everything after that is automatic.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Node Revision Limit**, or navigate
   directly to `/admin/config/content/node_revision_limit`.

## Set the number of revisions to keep

For each enabled language on your site, set the **number of revisions to keep**.
The default is **3**. This is the cap applied to every node: when a node is next
saved, any revisions older than the most recent *N* (plus the current one) are
deleted. Limits are applied independently per language, which is why multilingual
sites see a field per language.

You can also set **per‑content‑type limits** to override the global value for
specific types — for example, keep only 2 revisions on a high‑churn "News" type
while leaving a larger allowance elsewhere. Content types you do not restrict fall
back to the global limit.

## Save and let it run

Click **Save configuration**. Nothing is deleted at the moment you save — pruning
happens the next time each affected node is **updated**. From then on, every node
save trims that node's history back down to the configured limit, keeping the
current revision and the most recent versions and removing the surplus. There is
no cron job to schedule and no manual cleanup to run.

> **Tip:** Because pruning is triggered by node saves, existing over‑the‑limit
> nodes are only trimmed once they are next edited. If you want to reclaim space
> from nodes that are not being edited, you would need a separate bulk cleanup —
> this module bounds *future* growth transparently rather than doing a one‑off
> purge.
