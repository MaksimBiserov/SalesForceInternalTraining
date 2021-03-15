global class AsyncSceduledJob implements Schedulable {

    global void execute(SchedulableContext context) {
        Database.executeBatch(new AsyncBatchJobQueryLocator());
        Database.executeBatch(new AsyncBatchJobIterable());
    }

    public static void runSceduledJob() {
        String sch = '0 30 * * * ?';
        System.schedule('Run 2 batches every 30 minutes', sch, new AsyncSceduledJob());
    }
}

// Invoke:
// AsyncSceduledJob.runSceduledJob();