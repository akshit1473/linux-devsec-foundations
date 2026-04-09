linux-devsec-foundations
A structured, documented learning repo covering Linux systems fundamentals — built toward a DevOps career with a security lens throughout.
---
Repo structure
```
linux-devsec-foundations/
├── concepts/          ← written explanations of each topic, in my own words
├── scripts/           ← small tools built from concepts already covered
└── experiments/       ← lab notes: what I ran, what I observed, what surprised me
```
---
Topics covered so far
Process management — jobs, signals, states
Foreground vs background execution — `&`, `ctrl+z`, `fg`, `bg`
Signal model — SIGTERM, SIGKILL, SIGSTOP, SIGCONT, SIGHUP
Job vs process — shell-level vs kernel-level, JID vs PID
Process states — R, S, D, T, Z and what each means at the OS level
Zombie processes — why they're dangerous, how to find and resolve them
D state — why kill -9 doesn't work, and what to do instead
nohup + disown — surviving terminal close reliably
Process groups (PGID) — why ctrl+c kills whole pipelines
/proc — how ps aux actually works, and how to read process state directly
PATH and command resolution
PATH as an ordered, inherited environment variable
Full execution priority — alias → function → builtin → hash cache → PATH
Hash cache — what it is, why it causes bugs, how to clear it
Path hijacking — the full attack chain, line by line
Command overriding — fake binaries, `"$@"` for stealthy execution
Security hardening — absolute paths, PATH auditing, safe PATH in scripts
Debugging a broken PATH — recovery patterns using absolute paths
---
Topics in progress
Pipes and redirection — stdin, stdout, stderr, file descriptors
---
Scripts
See `scripts/` for tools built from the above concepts.
Each script has its own README explaining what it does, why it was built, and which concepts it uses.
------
