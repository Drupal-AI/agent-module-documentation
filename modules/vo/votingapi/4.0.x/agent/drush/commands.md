# Drush commands

Defined in `src/Drush/Commands/VotingApiDrushCommands.php` (Drush 12+ attributes).

## `voting:generate` (aliases `genv`, `generate-votes`)
Create dummy voting data for testing/theming.
```bash
drush voting:generate node                 # generate votes on all nodes
drush voting:generate node vote            # specify the vote type (default 'vote')
```
Options: `--kill_votes` (delete existing votes first), `--age` (max age in
seconds of each generated vote), `--node_types` (comma list, node only).
Generated votes use random values: `points` style → +1/-1, otherwise a
multiple of 20 (percent-style).

## `voting:recalculate` (aliases `vcalc`, `votingapi-recalculate`)
Rebuild aggregate results from raw votes.
```bash
drush voting:recalculate                   # entity_type defaults to 'node'
drush voting:recalculate comment           # for comment entities
drush voting:recalculate node vote 123     # one entity by id
```
Args: `entity_type` (default `node`), `vote_type` (default `vote`),
`entity_id` (optional — all entities of the type if omitted).

## `voting:flush` (aliases `vflush`, `votingapi-flush`)
Delete voting data (prompts for confirmation). Clears both `votingapi_vote` and
`votingapi_result`.
```bash
drush voting:flush all                      # everything (default)
drush voting:flush node                     # only node votes/results
drush voting:flush node 123                 # only entity 123
```
