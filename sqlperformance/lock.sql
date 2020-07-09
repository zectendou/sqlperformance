SELECT pid, query_start, substr(query, 0, 50) 
FROM pg_stat_activity WHERE state='active' ORDER BY query_start;

---とりあえずこれで様子見---

SELECT pg_cancel_backend(pid);

---これでキャンセルしてみる---

SELECT pg_terminate_backend(pid);

---これで滅ぼす---


SELECT l.pid,l.granted,d.datname,l.locktype,relation,relation::regclass,transactionid,l.mode
FROM pg_locks l  LEFT JOIN pg_database d ON l.database = d.oid
WHERE  l.pid != pg_backend_pid()
ORDER BY l.pid;

---これで最終確認して、残存勢力をキャンセルか滅ぼす。これでどうにかなるはず---