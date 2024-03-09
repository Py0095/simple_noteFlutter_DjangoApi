from rest_framework.decorators import api_view 
from rest_framework.response import Response
from .serializers import NoteSerializer
from .models import Note
from rest_framework import status
from django.http import Http404



@api_view(['GET'])
def getRoutes(request):
    routes = [
        {
            'Endpoint': '/notes/',
            'method': 'GET',
            'body': None,
            'description': 'Returns an array of notes'
        },
        {
            'Endpoint': '/notes/id',
            'method': 'GET',
            'body': None,
            'description': 'Returns a single note object'
        },
        {
            'Endpoint': '/notes/create/',
            'method': 'POST',
            'body': {'body': "", 'title': ""},
            'description': 'Creates a new note with data sent in post request'
        },
        {
            'Endpoint': '/notes/id/update/',
            'method': 'PUT',
            'body': {'body': "", 'title': ""},
            'description': 'Updates an existing note with data sent in post request'
        },
        {
            'Endpoint': '/notes/id/delete/',
            'method': 'DELETE',
            'body': None,
            'description': 'Deletes an existing note'
        }
    ]
    return Response(routes)

#get notes
@api_view(['GET'])
def getNotes(request):
    notes = Note.objects.all()
    serializer = NoteSerializer(notes, many=True)
    return Response(serializer.data)

#get note
@api_view(['GET'])
def getNote(request,pk):
    try:
        note = Note.objects.get(id=pk)
        serializer = NoteSerializer(note, many=False)
        return Response(serializer.data)
    except Note.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

#create notes
@api_view(['POST'])
def createNote(request):
    data = request.data
    note = Note.objects.create(
        title = data['title'],
        content = data['content']
    )
    serializer = NoteSerializer(note, many=False)
    return Response(serializer.data)

#update notes
@api_view(['PUT'])
def updateNote(request, pk):

    try:
        note = Note.objects.get(id=pk)
    except Note.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = NoteSerializer(instance=note, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

#delete note
@api_view(['DELETE'])
def deleteNote(request, pk):
    try:
        note = Note.objects.get(id=pk)
        note.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
    except Note.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)
