 update users set
    users.last_time = :LAST_TIME
where
    users.id = :ID
