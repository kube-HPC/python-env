FROM python:3
LABEL maintainer="hkube.dev@gmail.com"
LABEL description="This is a base algorithm for Python 3 env"

ADD requirements.txt /hkube/algorithm-runner/requirements.txt
WORKDIR /hkube/algorithm-runner
RUN pip3 install -r requirements.txt

COPY . /hkube/algorithm-runner
CMD ["python3", "-u", "app.py"]