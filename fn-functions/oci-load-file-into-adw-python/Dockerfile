FROM fnproject/python:3.8-dev as build-stage
WORKDIR /function
ADD requirements.txt /function/
ADD libaio-0.3.112-1.el8.x86_64.rpm /function/
COPY instantclient_21_5 /function/
RUN rpm -ivh /function/libaio-0.3.112-1.el8.x86_64.rpm
RUN pip3 install --target /python/  --no-cache --no-cache-dir -r requirements.txt && rm -fr ~/.cache/pip /tmp* requirements.txt func.yaml Dockerfile .venv && chmod -R o+r /python
ADD . /function/
RUN rm -fr /function/.pip_cache
FROM fnproject/python:3.8
WORKDIR /function
COPY --from=build-stage /python /python
COPY --from=build-stage /function /function
RUN chmod -R o+r /function
ENV PYTHONPATH=/function:/python
ENV LD_LIBRARY_PATH /function/instantclient_21_5
ENTRYPOINT ["/python/bin/fdk", "/function/func_ora.py", "handler"]
