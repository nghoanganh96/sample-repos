package com.grpc.service.temporal.worker;

import com.grpc.service.GateWayApplication;
import com.grpc.service.temporal.activity.AccountActivity;
import com.grpc.service.temporal.workflow.MoneyTransferWorkflow;
import com.grpc.service.temporal.workflow.MoneyTransferWorkflowImpl;
import io.temporal.worker.Worker;
import io.temporal.worker.WorkerFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@RequiredArgsConstructor
@Component
public class TemporalWorker {
    private final AccountActivity accountActivity;
    private final WorkerFactory workerFactory;

    @PostConstruct
    public void startTemporalWorker() {
        Worker worker = workerFactory.newWorker(MoneyTransferWorkflow.QUEUE_NAME);
        worker.registerWorkflowImplementationTypes(MoneyTransferWorkflowImpl.class);
        worker.registerActivitiesImplementations(accountActivity);
        workerFactory.start();
    }
}
