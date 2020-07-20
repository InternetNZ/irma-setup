# IRMA keyshare_server

a.k.a. [irma_keyhsare_server](https://github.com/InternetNZ/irma_keyshare_server)

The keyshare server has multiple responsibilities. First, it can validate the PIN entered by the user. Only then, the 
KSS allows the session to continue. Second, it can block a user for a certain amount of time if the user enters the 
PIN wrong too many times. Third, for users, it is also possible to block their account via the KSS website. 
