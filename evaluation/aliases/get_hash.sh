# calculate a hash? can we change it to calculate hashes for all the files?
get_hash()
(
    head -c32 /dev/urandom | openssl dgst -sha256 -binary -hmac $(xxd -p -l32 -c32 /dev/urandom) | base64 | cut -b-32
)


get_hash
