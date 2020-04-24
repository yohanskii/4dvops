FROM python:2.7-stretch
LABEL maintainer="yoann"
COPY . .
RUN apt-get update -y && apt-get install apt-utils python-dev python3-dev libsasl2-dev python-dev libldap2-dev libssl-dev -y
RUN pip install flask flask_httpauth flask_simpleldap python-dotenv
RUN mkdir data
VOLUME [ "/data" ]
EXPOSE 5000
CMD [ "python", "./student_age.py" ]
