# IRMA Mobile

a.k.a.: [irma_mobile](https://github.com/InternetNZ/irma_mobile)

Mobile client application for IRMA. Users need to install the IRMA app on her mobile device, which users can download 
from the official Android and iOS app stores. irma_mobile depends on irmago as the business logic is handled entirely 
within irmago. By implementing the data model and supporting code within irmago, the IRMA project only needs to maintain 
those in one central place.

irma_mobile is a react native application and more information can be found at repositories README file.

## Dev environment

To run IRMA Mobile on local environment, you may follow the project README. Some tips to be aware of:

- Project runs with node version 12
- After running install, you need to be sure that client is running through `yarn start`
- If your JDK is not jdk-8, you should:
  - set JAVA_HOME to jdk8 (ex: `export JAVA_HOME=/usr/lib/jvm/jdk-1.8.0-openjdk`)
  - add jdk8 to PATH (ex: `export PATH=$JAVA_HOME/bin:$PATH`)

