using Azure.Messaging.ServiceBus;
using Microsoft.Extensions.Configuration;
/*
var configuration = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
    .Build();

var client = new ServiceBusClient(configuration["ServiceBus:AzureServiceBusConnectionString"]);
var processor = client.CreateProcessor(configuration["ServiceBus:QueueName"], new ServiceBusProcessorOptions());

processor.ProcessMessageAsync += async args =>
{
    string body = args.Message.Body.ToString();
    Console.WriteLine($"Received message: {body}");
    await args.CompleteMessageAsync(args.Message);
};

processor.ProcessErrorAsync += args =>
{
    Console.WriteLine($"Error receiving message: {args.Exception.Message}");
    return Task.CompletedTask;
};

await processor.StartProcessingAsync();*/

Console.WriteLine("Listening for messages on the queue...");
Console.ReadLine();

//await processor.StopProcessingAsync();

