# DFuzz: Inter-Process Fuzzing of Distributed Systems 

This repository contains files to reproduce DFuzz's experiments.

`dfuzz` is the main binary. The binary should be invoked with `dfuzz PROJECT_PATH`.

Inside the `PROJECT_PATH`, there should be a `config.toml` to describe the configurations of fuzzing.

An example file for fuzzing JSON.
```
# Describes how to generate inputs.
[strategy]
type = 'afl' # Generate inputs with AFL's original strategy.

[executor]
type = 'inprocess' # Use this mode to fuzz utility programs.
program = { program = "../json-2017-02-12-inprocess.dfuzz-counter-instrument.out", args = [], has_null = false }

# Use this settings for fuzzer status inspection with RESTful API.
[history]
binary_cfg_mapping = {"../json-2017-02-12-inprocess-cfg.json"="../json-2017-02-12-inprocess-cfg.json"}
filesystem_interval = 60
remote_handler_server_addr = "127.0.0.1:3436"
```

When fuzzing distributed systems, the config file should be tweaked accordingly. The main difference is the executor type, where "daemon" should be used.

There are two kinds of executor configurations. The foreground executor must be set. It indicates the executor which interacts with DFuzz. The background executor can be omitted, because the group mappings can be transferred dynamically via API.

```
[strategy]
type = 'afl'
dictionary = {path="../sql.dict", level=10}

[executor]
type = 'daemon'
session_name = 'comdb2'

[executor.foreground]
spawn_timeout = 10000
execution_timeout=10

[executor.foreground.command]
program = '/root/ljie_workspace/comdb2/bin/fuzz.sh'

[executor.background]
spawn_timeout = 1000

[history]
binary_cfg_mapping = {"/root/ljie_workspace/comdb2/bin/comdb2.dfuzz-counter-instrument.out"="/root/ljie_workspace/comdb2/bin/comdb2-cfg.json","/root/ljie_workspace/comdb2/bin/cdb2sql.dfuzz-counter-instrument.out"="/root/ljie_workspace/comdb2/bin/cdb2sql-cfg.json"}
filesystem_interval = 10
report_interval = 10
```
