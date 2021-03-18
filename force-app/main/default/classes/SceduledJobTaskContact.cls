global class SceduledJobTaskContact implements Schedulable {
    global void execute(SchedulableContext context) {
        Database.executeBatch(new TaskBatchQueryLocator());
        Database.executeBatch(new ContactBatchIterable());
    }
}

// Invoke:
// String sch = '0 30 * * * ?';
// System.schedule('Run 2 batches every 30 minutes Task and Contact', sch, new SceduledJobTaskContact());